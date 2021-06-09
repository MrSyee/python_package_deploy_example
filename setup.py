from setuptools import find_packages, setup

with open("./requirements.txt", "r") as f:
    required = f.read().splitlines()

version_file = "dep/version"


def get_version():
    version = open(version_file, "r", encoding="utf-8").read().strip()
    return version

setup(
    name="dep",
    version=get_version(),
    author="kh.kim",
    author_email="khsyee@gmail.com",
    description="Package Deployment Test",
    url="https://github.com/MrSyee/python_package_deploy_example",
    packages=find_packages(),
    classifier=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    include_package_data=True,
    install_requires=required,
    python_requires=">=3.6",
    zip_safe=False,
    license="MIT",
)