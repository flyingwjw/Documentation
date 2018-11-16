import os


def list_dir(dirpath):
    dir_list = os.listdir(dirpath)
    basic["dir"] = {"dir": dir_list}
    print(basic)
    return dir_list


def log(dirpath):
    dir_list = list_dir(dirpath)
    print(dir_list)


if __name__ == '__main__':
    dirpath = "E:/share/3.0.3/ALEISSUE/ALE-268/Stellar/"
    log(dirpath)