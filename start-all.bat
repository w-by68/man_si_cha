@echo off
REM ============================================================
REM  漫思茶 Agent 改造 —— 一键启动全栈（本机 A 形态演示）
REM  启动顺序：MySQL -> Redis -> Nacos -> tearSpring(JDK8) -> agent-service(JDK17)
REM  用法：右键“以管理员身份运行”，或双击（MySQL 服务启停需管理员）
REM ============================================================
setlocal

set JAVA17=D:\dev-env\java\jdk-17.0.14
set JAVA8=D:\dev-env\java\jdk8\jdk8u504-b01
set MVN=D:\maven-3.9.6\apache-maven-3.9.6\bin\mvn.cmd
set NACOS_HOME=D:\dev-env\nacos\nacos
set LOGDIR=D:\dev-env\logs
set AGENT_DIR=D:\work\工作学习\agent骨架
set TEAR_DIR=D:\work\工作学习\2026027318-02素材与源码\源码\tearSpring

if not exist "%LOGDIR%" mkdir "%LOGDIR%"

echo [1/5] 启动 MySQL80 ...
net start MySQL80 >nul 2>&1
if errorlevel 1 (echo       已在运行或启动失败（需管理员）) else (echo       已启动)

echo [2/5] 启动 Redis ...
tasklist /FI "IMAGENAME eq redis-server.exe" | find /I "redis-server.exe" >nul
if errorlevel 1 (
  start "redis" /MIN D:\redis\redis-server.exe
  echo       已启动
) else (
  echo       已在运行
)

echo [3/5] 启动 Nacos (standalone) ...
netstat -ano | findstr ":8848" | findstr LISTENING >nul
if errorlevel 1 (
  set JAVA_HOME=%JAVA17%
  start "nacos" /MIN cmd /c ""%NACOS_HOME%\bin\startup.cmd" -m standalone"
  echo       已启动（约 15-30 秒就绪）
) else (
  echo       已在运行
)

echo [4/5] 启动 tearSpring (JDK8, 8080) ...
netstat -ano | findstr ":8080" | findstr LISTENING >nul
if errorlevel 1 (
  start "tearSpring" /MIN cmd /c "set JAVA_HOME=%JAVA8%&& cd /d "%TEAR_DIR%" && "%MVN%" -B spring-boot:run > "%LOGDIR%\tearSpring.log" 2>&1"
  echo       已启动
) else (
  echo       已在运行
)

echo [5/5] 启动 agent-service (JDK17, 8081) ...
netstat -ano | findstr ":8081" | findstr LISTENING >nul
if errorlevel 1 (
  REM LLM 配置从用户级环境变量读取（Key 不入库）；如未设置请先执行 setx
  start "agent-service" /MIN cmd /c "set JAVA_HOME=%JAVA17%&& set DB_PASSWORD=123456&& cd /d "%AGENT_DIR%" && "%MVN%" -B spring-boot:run > "%LOGDIR%\agent-service.log" 2>&1"
  echo       已启动
) else (
  echo       已在运行
)

echo.
echo 全部启动命令已发出。等待约 40 秒后访问：
echo   演示页      http://localhost:8081/chat.html
echo   Nacos 控制台 http://127.0.0.1:8848/nacos
echo   日志目录     %LOGDIR%
echo.
pause
