#include <stdio.h>
#include <stdlib.h>

char *get_string(int *len, int *test) {
    *len = 0; 
    *test = 0;
    int cp= 1; 
    char *s = (char*) malloc(sizeof(char)); 
    char c = getchar();
    if(c > 127){
      (*test)++;
    }  
    while (c != '\n') {
        s[(*len)++] = c; 
        if (*len >= cp) {
            cp *= 2; 
            s = (char*) realloc(s, cp * sizeof(char)); 
        }
        c = getchar();
        if(c > 127){
          (*test)++;
        }          
    }
    s[*len] = '\0'; 
    return s; 
}
void task(char *s, int len){
  for(int i = 0; i < len;i++){
	if((s[i] == 97) ||  (s[i] == 101) || (s[i] == 105) || (s[i] == 111) || (s[i] == 117) || (s[i] == 121)){
		s[i] = s[i] - 32;
	}
	printf("%c", s[i]);
  }
  printf("\n");
}
int main() {
    int len, test; 
    char *s = get_string(&len, &test); 
    if(test == 0){
      task(s, len);
      return 0; 
    }
    else{
      printf("incorrect input");
      return 0;
    } 
    free(s); 
    return 0;
}