import numpy as np
import os

# Get the output directory
current_directory = os.getcwd()
output_directory = os.path.join(current_directory, "output")

# Create array with all the initial conditions
ics_arr = np.linspace(0,1,51)

# Main loop over all the parameters
for i in ics_arr:
	for j in ics_arr:
		# Get into the folder
		i_str = "{:.2f}".format(i)
		j_str = "{:.2f}".format(j)
		ics = i_str + '-' + j_str
		folder_directory = os.path.join(output_directory, ics) 
		
		# Get the files
		nc = os.path.join(folder_directory, 'timeseries.nc') 
		result = os.path.join(folder_directory, 'output.txt') 
		
		# Get the winner
		with open(result, 'r') as f:
			lines = f.read().splitlines()
			last_line = lines[-1]
			if last_line.startswith('winners='):
			   outcome = last_line.split('=')[1].strip()
			   if outcome == 'humans':
			       result = 1
			   elif outcome == 'zombies':
			       result = 0
			   else:
			       result = None
			   print(result)
		

