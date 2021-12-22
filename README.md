# Python Package 배포 테스트
python package를 local pypi server에 올리고 pip install로 설치하는 절차를 테스트합니다.

# Local test
다음 절차로 테스트합니다.

```
python setup.py sdist

# Set pypiserver
pip install pypiserver
pypi-server -p 8008 ./dist

# localhost:8008
pip install --index-url http://localhost:8008/simple/ --trusted-host localhost dep

# test
python tools/check_package.py
```

# 서버 세팅 및 테스트
## (서버) id, passwd 세팅
```
pip install passlib

# "khkim" user의 passwd 설정
htpasswd -sc htpasswd.txt khkim
# passwd: rudghks

# .pypirc home/ 경로에 복사
cp .pypirc ~/.pypirc

# 서버의 패키지들을 보관할 디렉토리 생성
mkdir ~/packages
cp htpasswd ~/packages

# pypi server 실행
pypi-server -p 8008 -P htpasswd.txt ~/packages

```

## (클라이언트) upload
### python setup.py upload 사용
```
python setup.py sdist upload -r khkim

```
### 또는 twine 사용
```
pip install twine
python setup.py sdist
twine upload --repository local dist/*
```

### Poetry 를 이용한 패키지 배포

- Poetry repository 세팅 (`.pypirc`의 역할도 대신하기 때문에 해당 파일이 없어도 동작함.)

```
# repository 이름 (oplib 는 원하는 이름으로)
poetry config repositories.local http://10.10.30.16:8008

# 접속하기 위한 보안 정보 등록 (위에서 지정한 id, passwd로)
poetry config http-basic.local khkim rudghks
```

- 패키지 빌드 및 배포

```
# 위에서 설정한 repository 이름인 oplib로 배포
poetry publish -r oplib --build

# build가 이미 되어있는 경우
poetry publish -r oplib
```


### 특정 파일을 패키지에 추가하기
`MANIFEST.in` 파일에 include 한 후 setup.py에 `include_package_data=True`를 추가한다. (해당 파일 참고)

## (클라이언트) install
```
pip install --index-url http://localhost:8008 --trusted-host localhost:8008 [패키지 이름]
```

## (서버) Docker로 pypi 서버 실행
```
# dockerhub에서 pypiserver pull 받기
docker pull pypiserver/pypiserver:latest

# pypiserver 실행
docker run --rm -d -p 8008:8080 -v ~/packages:/data/packages pypiserver/pypiserver:latest -P /data/packages/htpasswd.txt --overwrite
```