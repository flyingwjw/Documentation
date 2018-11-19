import os
import sys
import csv
import time
import re
import datetime

class cur_env:
    path = sys.path[0]
    # print(path)
    os.chdir(path)
    result = path + '\\results'


class csv_writer:

    # get the log file list in the folder
    def get_files(self):
        file_list = list()
        files = os.listdir(cur_env.path)
        for file in files:
            if file.endswith('.log'):
                file_list.append(file)
        return file_list

    # generate result file name depend on run time
    def gen_filename(self):
        file_name = 'res_' + time.strftime('%y%m%d_%H%M%S', \
                                           time.localtime(time.time())) + '.csv'
        return file_name

    # create result folder if not exist
    def create_resFolder(self):
        if not os.path.isdir(cur_env.result):
            os.makedirs(cur_env.result)

    # write csv response time log
    def write_csv(self, file_name, content):
        csvfile = open(cur_env.result + '\\' + file_name, 'w+', newline='')
        headers = ['FILE NAME', 'TIMING(S)', 'LINE COUNT', 'DESC', 'WARNING']
        try:
            writer = csv.DictWriter(csvfile, headers)
            writer.writeheader()
            for con in content:
                con = dict(zip(headers, con))
                writer.writerow(con)
            # writer.writerow(headers)
            # writer.writerows(content)
        finally:
            del writer
            csvfile.close

    # generate contents from log files
    def gen_contents(self, file_list):
        content = list()
        for file in file_list:
            log = logger(file)
            log.generate_content()
            logcnt = log.content
            logcnt.insert(0, file)
            content.append(logcnt)
        return content


class logger:
    '''
    "generate 'TIMING','LINE COUNT','DESC','WARNING' from log files"
    '''

    def __init__(self, file):
        self.logfile = open(cur_env.path + '\\' + file, 'r+')
        self.content = dict()

    def generate_content(self):
        text = self.logfile.read()
        #print(text)
        # get total lines of the log file
        lines = text.count('\n')
        pattern = re.compile(r'\[.*\]')
        lsttime = re.findall(pattern, text)
        if (lines <= 0 or len(lsttime) <= 0):

            warning = 'Unknown issue. Please verify the format of your log file.'
            self.content = ['', '', '', warning]
            return
        start_time = str(lsttime[0])[1:-1]
        end_time = str(lsttime[-1])[1:-1]

        # get desc. log start time & end time
        desc = 'start time is: ' + start_time + '. end time is: ' + end_time

        # get the response time
        timing = time.mktime(time.strptime(end_time, '%Y-%m-%d %H:%M:%S')) \
                 - time.mktime(time.strptime(start_time, '%Y-%m-%d %H:%M:%S'))

        # verify if there is any error in the log
        pattern = re.compile(r'[Ee][Rr][Rr][Oo][Rr]')
        errors = len(re.findall(pattern, text))
        if (errors > 0):
            warning = 'Totally ' + str(errors) + ' error(s) detected in the log.'
        else:
            warning = 'NA'

        # generate result content
        self.content = [str(timing), str(lines), desc, warning]
        self.logfile.close()


# Testing code
writer = csv_writer()
writer.create_resFolder()
file_name = writer.gen_filename()
file_list = writer.get_files()
content = writer.gen_contents(file_list)
writer.write_csv(file_name, content)