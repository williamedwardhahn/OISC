#include <stdio.h>
#include <errno.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

#define MEMSIZE 8192

#define ROMSTART 0x0100

typedef uint16_t cell;

#define PC (*mem)

enum {
    _PC = 0x00,
    RA = 0x01,
    RB,
    RC,
    INCA,
    INCC,
    DECA,
    DECC,
    ADDAB,
    ASUBB,
    ALSHB,
    ARSHB,
    ARSHC,
    ALSHC,
    ANDAC,
    XORAC,
    ANDAB,
    ORAB,
    XORAB,
    NEGA,
    EQAB,
    NEQAB,
    ALTB,
    AGTB,
    INVERTA,
    INVERTC,
    AZEQ,
    CZEQ,
    CTERN,
    CMASK,
    CZNEQ,
    AZNEQ,
    IOEMIT = 0x20,
    IOKEY
};

int main(int argc, char *argv[]) {
    char *fname = "boot.rom";
    if (argc < 2) {
        fprintf(stderr, "Usage: %s <binary>\n", argv[0]);
    } else {
        fname = argv[1];
    }
    FILE *fp = fopen(fname, "rb");
    if (!fp) {
        fprintf(stderr, "Error %d opening %s: %s\n", errno, argv[1], strerror(errno));
        return -1;
    }
    cell *mem = calloc(sizeof(cell), MEMSIZE);
    if (!mem) {
        fprintf(stderr, "Error: cannot allocate memory\n");
        return -1;
    }
    fread(mem + ROMSTART, sizeof(cell), MEMSIZE-ROMSTART, fp);
    fclose(fp);
    PC = ROMSTART;
    cell s, v, d;
    int cycles = 0;
    while (PC) {
        cycles++;
        s = mem[PC++];
        d = mem[PC++];
        switch (s) {
            case INCA:
                v = mem[RA]+1;
                break;
            case INCC:
                v = mem[RC]+1;
                break;
            case DECA:
                v = mem[RA]-1;
                break;
            case DECC:
                v = mem[RC]-1;
                break;
            case ADDAB:
                v = mem[RA]+mem[RB];
                break;
            case ASUBB:
                v = mem[RA]-mem[RB];
                break;
            case ALSHB:
                v = mem[RA]<<mem[RB];
                break;
            case ARSHB:
                v = mem[RA]>>mem[RB];
                break;
            case ARSHC:
                v = mem[RA]>>mem[RC];
                break;
            case ALSHC:
                v = mem[RA]<<mem[RC];
                break;
            case ANDAC:
                v = mem[RA]&mem[RC];
                break;
            case XORAC:
                v = mem[RA]^mem[RC];
                break;
            case ANDAB:
                v = mem[RA]&mem[RB];
                break;
            case ORAB:
                v = mem[RA]|mem[RB];
                break;
            case XORAB:
                v = mem[RA]^mem[RB];
                break;
            case NEGA:
                v = ~mem[RA];
                break;
            case EQAB:
                v = -(mem[RA]==mem[RB]);
                break;
            case NEQAB:
                v = -(mem[RA]!=mem[RB]);
                break;
            case ALTB:
                v = -(mem[RA]<mem[RB]);
                break;
            case AGTB:
                v = -(mem[RA]>mem[RB]);
                break;
            case INVERTA:
                v = ~mem[RA];
                break;
            case INVERTC:
                v = ~mem[RC];
                break;
            case AZEQ:
                v = -(mem[RA]==0);
                break;
            case CZEQ:
                v = -(mem[RC]==0);
                break;
            case CTERN:
                v = mem[RC]?mem[RA]:mem[RB];
                break;
            case CMASK:
                v = mem[RC]&mem[RA];
                break;
            case CZNEQ:
                v = -(mem[RC]!=0);
                break;
            case AZNEQ:
                v = -(mem[RA]!=0);
                break;
            case IOKEY:
                v = getchar();
                if (v == (cell)EOF) {
                    PC = 0;
                    fprintf(stderr, "\nHit EOF, Halting now\n");
                } else {
                    fprintf(stderr, "\nGot '%c' (%d)\n", v, v);
                }
                break;
            default:
                v = mem[s];
        }
        mem[d] = v;
        switch (d) {
            case IOEMIT:
                printf("%c",v);
                break;
        }
        fprintf(stderr, "%04x: %04x (%04x) %04x\n", PC-2, s, v, d);
    }
    printf("\nMachine halted after %d cycles\n", cycles);
    free(mem);
    return 0;
}
