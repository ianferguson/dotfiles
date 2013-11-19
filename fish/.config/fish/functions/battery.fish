function battery
	ioreg -l | grep -i capacity | tr '\n' ' | ' | awk '{printf(%.2f%%, / * 100)}'; 
end
