#!/bin/bash

# 这里可替换为你自己的执行程序，其他代码无需更改
APPLICATION=myapp
PROFILES_ACTIVE=local

# =================================
# 进入bin目录
cd `dirname $0`

# 返回到上一级项目根目录路径
cd ..

# `pwd` 执行系统命令并获得结果
BASE_PATH=`pwd`

# 项目日志输出绝对路径
LOG_PATH="${BASE_PATH}/logs/app.log"

# 如果logs文件夹不存在,则创建文件夹
if [ ! -d `dirname ${LOG_PATH}` ]; then
  mkdir `dirname ${LOG_PATH}`
fi

# 当前时间
NOW=`date "+%Y-%m-%d-%H-%M-%S"`
NOW_PRETTY=`date "+%Y-%m-%d %H:%M:%S"`

# 使用说明，用来提示输入参数
usage() {
    echo ">>> Usage: sh 脚本名.sh [start|stop|restart|status]"
    exit 1
}

# 检查程序是否在运行
is_exist() {
    pid=`ps -ef|grep $APPLICATION.jar|grep -v grep|awk '{print $2}' `
    # 如果不存在返回1，存在返回0
    if [ -z "${pid}" ]; then
        return 1
    else
        return 0
    fi
}

#==========================================================================================
# JVM Configuration
# -Xmx1g:设置JVM最大可用内存为1G。
# -Xms1g:设置JVM初始内存41。此值可以设置与-Xmx相同,以避免每次垃圾回收完成后JVM重新分配内存
# -Xmn512m:设置年轻代大小为512m。整个JVM内存大小=年轻代大小 + 年老代大小 + 持久代大小。
#          持久代一般固定大小为64m,所以增大年轻代,将会减小年老代大小。此值对系统性能影响较大,Sun官方推荐配置为整个堆的3/8
# -XX:MetaspaceSize=64m:存储class的内存大小,该值越大触发Metaspace GC的时机就越晚
# -XX:MaxMetaspaceSize=320m:限制Metaspace增长的上限，防止因为某些情况导致Metaspace无限的使用本地内存，影响到其他程序
# -XX:-OmitStackTraceInFastThrow:解决重复异常不打印堆栈信息问题
#==========================================================================================
JAVA_OPT="-server -Xms512m -Xmx512m -Xmn256m -XX:MetaspaceSize=32m -XX:MaxMetaspaceSize=128m"
JAVA_OPT="${JAVA_OPT} -XX:-OmitStackTraceInFastThrow"

# 启动方法
start() {
    is_exist
    if [ $? -eq "0" ]; then
        echo ">>> ${APPLICATION} is already running. pid=${pid}"
    else
        # 启动日志
        STARTUP_LOG="================================================ ${NOW_PRETTY} ================================================\n"

        #=======================================================
        # 将命令启动相关日志追加到日志文件
        #=======================================================

        # 输出项目名称
        STARTUP_LOG="${STARTUP_LOG}>>> Application name: ${APPLICATION}\n"

        # 输出jar包名称
        STARTUP_LOG="${STARTUP_LOG}>>> Application jar name: ${APPLICATION}.jar\n"

        # 输出项目根目录
        STARTUP_LOG="${STARTUP_LOG}>>> Application root path: ${BASE_PATH}\n"

        # 打印日志路径
        STARTUP_LOG="${STARTUP_LOG}>>> Application log path: ${LOG_PATH}\n"

        # 打印JVM配置
        STARTUP_LOG="${STARTUP_LOG}>>> Application JAVA_OPT: ${JAVA_OPT}\n"

        # 打印启动命令
        STARTUP_LOG="${STARTUP_LOG}>>> Application background startup command: nohup java ${JAVA_OPT} -jar ${BASE_PATH}/lib/${APPLICATION}.jar --spring.profiles.active=${PROFILES_ACTIVE} --spring.config.location=${BASE_PATH}/config/ > ${LOG_PATH} 2>&1 &\n"


        #======================================================================
        # 执行启动命令：后台启动项目,并将日志输出到项目根目录下的logs文件夹下
        #======================================================================
        #nohup java ${JAVA_OPT} -jar ${BASE_PATH}/lib/${APPLICATION}.jar --spring.profiles.active=${PROFILES_ACTIVE} --spring.config.location=${BASE_PATH}/config/ > ${LOG_PATH} 2>&1 &
        nohup java ${JAVA_OPT} -jar ${BASE_PATH}/lib/${APPLICATION}.jar --spring.profiles.active=${PROFILES_ACTIVE} --spring.config.location=${BASE_PATH}/config/ > /dev/null 2>&1 &

        # 进程ID
        PID=$(ps -ef | grep ${APPLICATION}.jar | grep -v grep | awk '{ print $2 }')
        STARTUP_LOG="${STARTUP_LOG}>>> Application pid: ${PID}\n"

        STARTUP_LOG="${STARTUP_LOG}================================================ ${NOW_PRETTY} ================================================\n"

        # 打印启动日志
        echo -e ${STARTUP_LOG}

        # 打印项目日志
        #tail -F ${LOG_PATH}
    fi
}

# 停止方法
stop(){
    is_exist
    if [ $? -eq "0" ]; then
        kill -9 $pid
        echo ">>> ${APPLICATION} is stopping ..."
        sleep 1
        echo "."
        sleep 1
        echo ".."
        sleep 1
        echo "..."
        sleep 1
        echo "...."

        is_exist
        if [ $? -eq "0" ]; then
            echo ">>> ${APPLICATION} is stoped FAIL"
        else
            echo ">>> ${APPLICATION} is stoped SUCCESS"
        fi
    else
        echo ">>> ${APPLICATION} is not running"
    fi
}

# 输出运行状态
status() {
    is_exist
    if [ $? -eq "0" ]; then
        echo ">>> ${APPLICATION} is running. pid is ${pid}"
    else
        echo ">>> ${APPLICATION} is NOT running."
    fi
}

# 重启
restart() {
    stop
    start
}

# 根据输入参数，选择执行对应方法，不输入则执行使用说明
case "$1" in
    "start")
    start
    ;;
    "stop")
    stop
    ;;
    "status")
    status
    ;;
    "restart")
    restart
    ;;
    *)
    usage
    ;;
esac
