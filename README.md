# Xcode_iOS_SantaClaus_3D_VR_Gyro_game_2011
For Christmas 2011, I have created this iOS VR game where you have to travel in 3D to capture gifts that the Santa Claus is spreading on is way. 

Note: This code was rebuild in 2015 under Xcode7, and there are some artifacts that were not there in a previous version:
-there is a lag for the device orientation,
-there is debug information on the iPad screen,
-the displacement in space sometime has slightly strange behaviour, probably due to gimbal lock issues.

Note: The initial game goal was use the iPad surface as the circle of a butterfly net.
To do that, I have tried to double integrate the iPad accelerometer information to obtain the current relative position.
However since the iPad accelerometer MEMS chip has bias, hysterisys and other non-linearity effects, this way proved to be impossible and I had to change slightly the mechanic of the game.
