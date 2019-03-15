LIB_DIR = lib

default: isisimtq

pyexamples: setup.py isisimtq.pyx $(LIB_DIR)/libimtq.a
	python3 setup.py build_ext --inplace && rm -f isisimtq.c && rm -Rf build

$(LIB_DIR)/libimtq.a:
	make -C $(LIB_DIR) libimtq.a

clean:
	rm *.so
