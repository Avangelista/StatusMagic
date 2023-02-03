#pragma once
char* get_temp_file_path(void);
void test_nsexpressions(void);
char* set_up_tmp_file(void);

void xpc_crasher(char* service_name);

void respringFrontboard(void);
void respringBackboard(void);

#define ROUND_DOWN_PAGE(val) (val & ~(PAGE_SIZE - 1ULL))
