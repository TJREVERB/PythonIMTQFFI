from distutils.core import setup
from distutils.extension import Extension
from Cython.Build import cythonize

examples_extension = Extension(
    name="isisimtq",
    sources=["isisimtq.pyx"],
    libraries=["imtq"],
    library_dirs=["lib"],
    include_dirs=["lib"]
)
setup(
    name="isisimtq",
    ext_modules=cythonize([examples_extension])
)
