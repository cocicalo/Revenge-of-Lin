/// @description Основные переменные

cam=view_camera[0];
follow=ObjPlayer;
// Делим ширину и высоту на половину
view_w_half=camera_get_view_width(cam)*0.5;
view_h_half=camera_get_view_height(cam)*0.5;

xTo=xstart;
yTo=ystart;
//Плавность движения
smoothness = 25;