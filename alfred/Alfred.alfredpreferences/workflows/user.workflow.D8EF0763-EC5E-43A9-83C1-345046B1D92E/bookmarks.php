<?php

require('extension_utils.php');

$utils = new ExtensionUtils();
$db = new LocalDB('bookmarks.db');

$input = $argv[1];

// set up the structure for the database tables
$bookmarks_table_fields = array( 'name' => 'text', 'url' => 'text' );
$settings_table_fields = array( 'updated' => 'integer', 'bookmarks' => 'text' );

// create the database tables
$db->createTable( 'bookmarks', $bookmarks_table_fields );
$db->createTable( 'settings', $settings_table_fields );

// grab the currently saved settings, if they exist
$settings = $db->single( 'settings' );

if ( empty( $settings->updated ) && empty( $settings->bookmarks ) ): // no settings
	$home = exec('printf $HOME');
	$bookmarks_path = $home.'/Library/Application Support/Google/Chrome/Default/Bookmarks';
	if ( !file_exists( $bookmarks_path ) ):
		$result = $utils->item(
			'notfound',
			'notfound',
			'Bookmarks File Not Found',
			'Unable to locate your bookmarks file',
			'icon.png',
			true );
		$results = array( $result );
		echo $utils->arrayToXML( $results );
	else:
		$updated = time();
		$db->insert( 'settings', array( 'updated' => $updated, 'bookmarks' => $bookmarks_path ) );
		$bookmark_data = json_decode( file_get_contents( $bookmarks_path ) );
		update_bookmarks( $bookmark_data->roots );
	endif;
else: // settings found
	$filemod = filemtime( $settings->bookmarks );
	if ( $filemod > $settings->updated ): // if the file is newer than the last update time

		// Drop the bookmarks table and recreate it
		$db->dropTable( 'bookmarks' );
		$bookmarks_table_fields = array(
			'name' => 'text',
			'url' => 'text'
		);
		$db->createTable( 'bookmarks', $bookmarks_table_fields );

		$bookmark_data = json_decode( file_get_contents( $settings->bookmarks ) );
		update_bookmarks( $bookmark_data->roots, $settings->updated );
	else:
		//just search
	endif;
endif;

$matches = $db->get( 'bookmarks', 'name LIKE "%'.$input.'%" or url LIKE "%'.$input.'%"' );

$results = array();
foreach( $matches as $match ):
	$item = array(
		'uid' => htmlentities( $match->url ),
		'arg' => htmlentities( $match->url ),
		'title' => htmlentities( $match->name ),
		'subtitle' => htmlentities( $match->url ),
		'icon' => 'icon.png'
	);
	array_push( $results, $item );
endforeach;
if ( count($results) == 0 ):
	$item = array(
		'uid' => 'none',
		'arg' => 'none',
		'title' => 'No bookmarks found',
		'subtitle' => 'No bookmarks matching your querey were found',
		'icon' => 'icon.png',
		'valid' => 'no'
	);
array_push( $results, $item );
endif;
echo $utils->arrayToXML( $results );


function update_bookmarks( $obj, $since='all' )
{
	global $db;

	foreach( $obj as $bm ):
		if ( $bm->type == 'folder' ):
			update_bookmarks( $bm->children, $since );
		else:
			if ( $since != 'all' ): // if a date was given
				if ( $bm->date_added > $since ): // if its new, add it
					$item = array( 'name' => $bm->name, 'url' => $bm->url );
					$db->insert( 'bookmarks', $item );
				else:	// if its not new, continue to the next
					continue;
				endif;
			else: // if $since was set to all, get if
				$item = array( 'name' => $bm->name, 'url' => $bm->url );
				$db->insert( 'bookmarks', $item );
			endif;
		endif;
	endforeach;
}