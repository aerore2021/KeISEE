/*************************** HEADER FILES ***************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


/****************************** MACROS ******************************/
#define SHL(x,n) (x<<n)
#define SHR(x,n) (x>>n)
#define ROTL(x,n) ((x<<n)|(x>>(32-n)))
#define ROTR(x,n) ((x>>n)|(x<<(32-n)))

#define P1(a,b,c,d,e) (P2((a)^(b)^ROTL((c),15))^ROTL((d),7)^e)
#define P2(a) ((a)^ROTL((a),15)^ROTL((a),23))
#define P3(a,b) ((a)^(b))
#define P4(a) ((a)^ROTL((a),9)^ROTL((a),17))
#define T1 (0x79cc4519)
#define T2 (0x7a879d8a)
#define FF1(a,b,c) ((a)^(b)^(c))
#define FF2(a,b,c) (((a)&(b))|((a)&(c))|((b)&(c)))
#define GG1(a,b,c) ((a)^(b)^(c))
#define GG2(a,b,c) (((a)&(b))|((~a)&(c)))
#define SS1(a,b,c,d) (ROTL((ROTL((a),12)+b+ROTL((c),(d))),7))
#define SS2(a,b,c,d) (SS1((a),(b),(c),(d))^ROTL((a),12))
#define TT1(e,f,g,a,b,c,d) ((e)+(f)+SS2(a,b,c,d)+(g))
#define TT2(e,f,g,a,b,c,d) ((e)+(f)+SS1(a,b,c,d)+(g))

/**************************** VARIABLES *****************************/
unsigned long H[8] = {0x7380166f, 
                      0x4914b2b9, 
                      0x172442d7, 
                      0xda8a0600, 
                      0xa96f30bc, 
                      0x163138aa, 
                      0xe38dee4d, 
                      0xb0fb0e4e};


int print_str(unsigned char *str, int len)
{
    int i = 0;

    printf("hash: ");

    for(i=0; i<len; i++)
    {
        printf("%02X", str[i]);
    }

    printf("\n");

    return 0;
}

int sm3_long_to_str(unsigned long a, unsigned char *b)
{
    unsigned long x = a;
    unsigned char *d = (unsigned char *)&x;

    b[0] = d[3];
    b[1] = d[2];
    b[2] = d[1];
    b[3] = d[0];

    return 0;
}

unsigned long sm3_str_to_long(unsigned char *a)
{
    unsigned long x = 0;
    unsigned char *b = (unsigned char *)&x;

    b[0] = a[3];
    b[1] = a[2];
    b[2] = a[1];
    b[3] = a[0];

    return x;
}

int sm3_pad_message(unsigned char *str, int len)
{
    unsigned long high, low;
    int u = len % 64;

    high = 0;
    low = len * 8;

    if(u < 56)
    {
        str[len++] = 0x80;
        u++;

        while(u < 56)
        {
            str[len++] = 0x00;
            u++;
        }
    }
    else if(u > 56)
    {
        str[len++] = 0x80;
        u++;

        while(u < 56+64)
        {
            str[len++] = 0x00;
            u++;
        }
    }

    str[len++] = high >> 24;
    str[len++] = high >> 16;
    str[len++] = high >> 8;
    str[len++] = high;
    str[len++] = low >> 24;
    str[len++] = low >> 16;
    str[len++] = low >> 8;
    str[len++] = low;

    return len;
}

int sm3_group_a(unsigned char *a, unsigned char *b, unsigned char *c, unsigned char *d, unsigned char *e, unsigned char *f)
{
    unsigned long x[6] = {0};

    x[0] = sm3_str_to_long(a);
    x[1] = sm3_str_to_long(b);
    x[2] = sm3_str_to_long(c);
    x[3] = sm3_str_to_long(d);
    x[4] = sm3_str_to_long(e);
    x[5] = P1(x[0],x[1],x[2],x[3],x[4]);

    sm3_long_to_str(x[5], f);

    return 0;
}

int sm3_group_b(unsigned char *a, unsigned char *b, unsigned char *c)
{
    unsigned long x[3] = {0};

    x[0] = sm3_str_to_long(a);
    x[1] = sm3_str_to_long(b);
    x[2] = P3(x[0],x[1]);

    sm3_long_to_str(x[2], c);

    return 0;
}

int sm3_str_group(unsigned char *str, int len)
{
    unsigned char M[64];
    unsigned char W[68][4];
    int u = len / 64;
    int v = 64 / 16 * 64 * 2;
    int i = 0;
    int j = 0;

    for(i=u-1; i>=0; i--)
    {
        memset(M, 0x00, sizeof(M));

        memcpy(M, str+i*64, 64);

        for(j=0; j<16; j++)
        {
            memcpy(W[j], M+4*j, 4);
        }

        for(j=16; j<68; j++)
        {
            sm3_group_a(W[j-16], W[j-9], W[j-3], W[j-13], W[j-6], W[j]);
        }

        memset(M, 0x00, sizeof(M));

        for(j=0; j<64; j++)
        {
            sm3_group_b(W[j], W[j+4], M);
            memcpy(str+i*v+8*j, W[j], 4);
            memcpy(str+i*v+8*j+4, M, 4);
        }
    }

    return u*v;
}

int sm3_str_summ(unsigned char *str, unsigned char *summ, int len)
{
    unsigned char W[128][4];
    unsigned long A[8] = {0};
    unsigned long B[8] = {0};
    unsigned long C[8] = {0};
    int u = len / 512;
    int i = 0;
    int j = 0;

    memcpy(B, H, sizeof(B));

    for(i=0; i<u; i++)
    {
        for(j=0; j<128; j++)
        {
            memcpy(W[j], str+i*512+j*4, 4);
        }

        A[0] = B[0];
        A[1] = B[1];
        A[2] = B[2];
        A[3] = B[3];
        A[4] = B[4];
        A[5] = B[5];
        A[6] = B[6];
        A[7] = B[7];

        for(j=0; j<16; j++)
        {
            C[0] = sm3_str_to_long(W[2*j+1]);
            C[1] = sm3_str_to_long(W[2*j]);
            C[2] = TT1(FF1(A[0],A[1],A[2]),A[3],C[0],A[0],A[4],T1,j);
            C[3] = TT2(GG1(A[4],A[5],A[6]),A[7],C[1],A[0],A[4],T1,j);
            A[7] = A[6];
            A[6] = ROTL(A[5],19);
            A[5] = A[4];
            A[4] = P4(C[3]);
            A[3] = A[2];
            A[2] = ROTL(A[1],9);
            A[1] = A[0];
            A[0] = C[2];
        }

        for(j=16; j<64; j++)
        {
            C[0] = sm3_str_to_long(W[2*j+1]);
            C[1] = sm3_str_to_long(W[2*j]);
            C[2] = TT1(FF2(A[0],A[1],A[2]),A[3],C[0],A[0],A[4],T2,j);
            C[3] = TT2(GG2(A[4],A[5],A[6]),A[7],C[1],A[0],A[4],T2,j);
            A[7] = A[6];
            A[6] = ROTL(A[5],19);
            A[5] = A[4];
            A[4] = P4(C[3]);
            A[3] = A[2];
            A[2] = ROTL(A[1],9);
            A[1] = A[0];
            A[0] = C[2];

            //printf("A[0]=[%08X]\n", A[0]);
        }

        B[0] ^= A[0];
        B[1] ^= A[1];
        B[2] ^= A[2];
        B[3] ^= A[3];
        B[4] ^= A[4];
        B[5] ^= A[5];
        B[6] ^= A[6];
        B[7] ^= A[7];
    }

    sm3_long_to_str(B[0], summ);
    sm3_long_to_str(B[1], summ+4);
    sm3_long_to_str(B[2], summ+8);
    sm3_long_to_str(B[3], summ+12);
    sm3_long_to_str(B[4], summ+16);
    sm3_long_to_str(B[5], summ+20);
    sm3_long_to_str(B[6], summ+24);
    sm3_long_to_str(B[7], summ+28);

    return 0;
}

int main()
{
    unsigned char str[64*8*8] = {0};
    unsigned char str_sm3[32];
    int len = 5;
    int i = 0;

    printf("Please input string: ");
    scanf("%s", str);

    len = sm3_pad_message(str, len);

    len = sm3_str_group(str, len);

    sm3_str_summ(str, str_sm3, len);

    print_str(str_sm3, 32);

    return 0;
}