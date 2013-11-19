function gittidy_all
	for DIR in (ls $GITHOME) 
        pushd $GITHOME/$DIR
        echo $DIR
        git checkout master
        and git pull 
        and git checkout develop
        and git pull
        popd 
    end; 
end
