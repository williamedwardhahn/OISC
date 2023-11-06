%.sym: %.irtext machine.sym
	grep -oe '\S\+' $< | sed ':a;N;$$!ba;s/\n\([^:]*:\)/ \1/g' | grep -one '\S\+:' | awk -F ':' '{ printf "%04x %s\n", $$1+255, $$2 }' | cat $(word 2,$^) - > $@

%.hex: %.irtext %.sym
	grep -oe '\S\+' $< | grep -v ':' | awk 'FNR == NR { mapping[$$2] = $$1; next } { if ($$1 in mapping) { print mapping[$$1]; } else if ($$1 == "_") { print "0000"; } else if (substr($$1, 1, 1) == "+") { printf "%04x\n", substr($$1, 2) + FNR + 255; } else { if ($$1 < 0) { printf "%04x\n", 65536 + $$1; } else { printf "%04x\n", $$1; } } }' $(word 2,$^) - > $@

%.rom: %.hex
	xxd -r -p $< | xxd -e -g 2 -c 2 | xxd -r > $@

%: %.c
	cc -o $@ $<

.PHONY: all clean
all: oiscx boot.rom boot.sym
clean:
	rm -f oiscx boot.rom boot.sym boot.hex