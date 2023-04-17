import numpy as np
import os

# This function would obtain the winner in the given folder
def getwinner(result):
	with open(result, 'r') as f:
		lines = f.read().splitlines()
		last_line = lines[-1]
		if last_line.startswith('winners='):
			outcome = last_line.split('=')[1].strip()
			if outcome == 'humans':
				with open('humanswin.dat', 'a') as humans_file:
					humans_file.write(i_str + ' ' + j_str + '\n')
			elif outcome == 'zombies':
				with open('zombieswin.dat', 'a') as zombies_file:
					zombies_file.write(i_str + ' ' + j_str + '\n')

# This function resets the humanswin.dat and zombieswin.dat
def reset_winnerfiles():
	if os.path.exists('humanswin.dat'):
		os.remove('humanswin.dat')
	if os.path.exists('zombieswin.dat'):
		os.remove('zombieswin.dat')
	with open('humanswin.dat', 'a') as humans_file:
		humans_file.write('Y(0) Z(0)' + '\n')
	with open('zombieswin.dat', 'a') as zombies_file:
		zombies_file.write('Y(0) Z(0)' + '\n')

# Get the output directory
current_directory = os.getcwd()
output_directory = os.path.join(current_directory, "output")

# Create array with all the initial conditions
ics_arr = np.linspace(0,1,51)

reset_winnerfiles()

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
		getwinner(result)
		

