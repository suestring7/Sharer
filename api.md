# API
## 登录
POST '/api/user/signin'
+ username
+ password

{ 'code': 0(Normal) / 1(Abnormal),

  'message': '' }

## 注册
POST '/api/user/signup'
+ username
+ password

## 登出
GET '/api/user/signout'


# Start up
iojs / node 命令应该有反应(source ~/.nvm/nvm.sh)
	
	+nvm use iojs
	+nvm alias default iojs

首先保证MongoDB跑在27017端口(Robomongo)

```
git clone ...
npm install -g bower gulp
npm install
bower install
gulp
```

http://localhost:3000
