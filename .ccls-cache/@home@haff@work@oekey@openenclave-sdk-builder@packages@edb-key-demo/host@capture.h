#ifndef __CAPTURE_H_
#define __CAPTURE_H_


extern int g_capture_frames;
extern const char *g_capture_path;

int capture_loop(const char *cam_dev);


#endif /* __CAPTURE_H_ */
