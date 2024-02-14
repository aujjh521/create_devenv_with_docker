練習使用docker創建完整的開發環境
可以分成兩種模式 (在dockerfile_template folder裡面有兩種各自的dockerdile範例)
1. dockerfile創建單一環境, 並透過vscode or jupyterlab連到container裡面做開發 (同時mount 本地資料夾做資料儲存)
2. dockerfile裡面安裝miniconda, 並透過conda管理container裡面的環境 (目前的問題是container如果關掉, 透過conda後續安裝的package會在下次重啟container的時候消失)

主要參考的教學 (notion裡面也有紀錄)
1. https://zhuanlan.zhihu.com/p/646152162
2. https://linuxhandbook.com/dockerize-python-apps/

常用指令
1. 建立image: docker image build -t devenv_with_docker .
2. 刪除所有運行中的container: docker container rm --force $(docker container ls --all --quiet)
3. 啟動container (使用gpu & mount本地硬碟路徑到container)
    docker run -it --gpus all -v G:\git_repo\create_devenv_with_docker:/pc_workspace devenv_with_docker

4. 在vscode連進去的container環境中打開jupyterlab: python -m jupyterlab --no-browser --ip=0.0.0.0 --allow-root

