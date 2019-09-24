
int rawhid_open(int max, int vid, int pid, int usage_page, int usage);
int rawhid_recv(int num, void *BUFFER_OUTPUT, int LENGTH_OUTPUT, int timeout);
int rawhid_send(int num, void *BUFFER_INPUT, int LENGTH_INPUT, int timeout);
void rawhid_close(int num);

