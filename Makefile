# 项目编译与打包
# 注意：Makefile内的shell和正常shell有区别
# 千万注意 Makefile 格式必须用Tab，不能用space

# 这里可替换为你自己的执行程序，其他代码无需更改
APPLICATION=myapp
PROFILES_ACTIVE=local

# 项目实际运行目录
TARGET_DIR=../${APPLICATION}_target

# .PHONY是一个伪目标，可以有效防止在Makefile文件中定义的可执行命令的目标规则
# 和工作目录下的实际文件出现名称冲突，并提高了执行Makefile的性能。
.PHONY: clean package

all:
	@echo "USAGE: make 命令名称"
	@echo "可选命令：build | rebuild | clean | start | stop | status | restart"

build: git_update clean package
	@echo " "
	@echo "===================================="
	@echo "=> ::build:: 任务执行完成"

rebuild: build restart
	@echo " "
	@echo "===================================="
	@echo "=> ::rebuild:: 任务执行完成"

git_update:
	git pull

	@echo " "
	@echo "---------------"
	@echo "=> ::git_update:: 任务执行完成"

clean:
	mvn clean

	@echo " "
	@echo "---------------"
	@echo "=> ::clean:: 任务执行完成"

package:
	@echo " "

	@# 打包 - 这里是不输出的注释
	mvn package -P ${PROFILES_ACTIVE}
	@echo ">>> APPLICATION JAR构建完成 ...... OK"
	@echo " "

	@echo ">>> 创建 ${TARGET_DIR} 目录 ..."
	@if [ ! -e ${TARGET_DIR} ]; then\
		mkdir ${TARGET_DIR};\
		mkdir ${TARGET_DIR}/logs;\
		echo "     ......目录创建，OK";\
	else \
		echo "     ......目录已存在，SKIP";\
	fi \

	@echo " "

	@echo ">>> 正在清理旧的编译文件..."
	cd ${TARGET_DIR}; rm -rfv `ls |grep -v "logs"`;
	@echo ">>> 清理旧的编译文件 ...OK"
	@echo " "

	@echo ">>>>>>>>> 正在部署到指定目录..."
	@cp -rfv target/${APPLICATION}-server-assembly/${APPLICATION}-server/* ${TARGET_DIR}/
	@chmod 755 ${TARGET_DIR}/bin/*.sh
	@echo ">>> 部署到指定目录 ... OK"

	@echo " "
	@echo "---------------"
	@echo "=> ::package:: 任务执行完成"

status:
	@sh ${TARGET_DIR}/bin/startup.sh status

	@echo " "
	@echo "---------------"
	@echo "=> ::status:: 任务执行完成"

restart:
	@sh ${TARGET_DIR}/bin/startup.sh restart

	@echo " "
	@echo "---------------"
	@echo "=> ::restart:: 任务执行完成"

start:
	@sh ${TARGET_DIR}/bin/startup.sh start

	@echo " "
	@echo "---------------"
	@echo "=> ::start:: 任务执行完成"

stop:
	@sh ${TARGET_DIR}/bin/startup.sh stop

	@echo " "
	@echo "---------------"
	@echo "=> ::stop:: 任务执行完成"
