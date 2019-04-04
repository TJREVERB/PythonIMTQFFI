# PythonFFI
Clone it
"cd" into the PythonFFI repository
Write "cd lib"
Then write "gcc -c i2c.c"
Then "ar rcs libn.a i2c.o"
Then "gcc -c ants.c"
Then "ar rcs libants.a ants.o"
Then "cd .."
Then "python3 setup.py build_ext --inplace"
This creates 2 files: isisants.c and isisants.cpython-36m-arm-linux-gnueabihf.so
Example of use in terminal:
  import isisants
  isisants.py_k_ants_cancel_deploy()
