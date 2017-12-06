import re
# return a list format is below, order by time
def log_analysis(logfile, descprition='second'):
    result_list = []
    # res_list = [ hour, minute, second, path, success_code, count ]
    with open(logfile, "r+", encoding="utf-8") as f:
        for line in f:
            success_code = 0
            column = line.split()
            if re.match("^[123]",column[8]):
                success_code = 1
            temp_list = [
                        column[3].split(':')[1],    # 0 hour
                        column[3].split(':')[2],    # 1 minute
                        column[3].split(':')[3],    # 2 second
                        column[6],                  # 3 path
                        success_code,               # 4 success_code
                        1                           # 5 total
                        ]
            if descprition == 'minute':
                del temp_list[2]
            if descprition == 'second':
                for temp in result_list:
                    if temp[0] == temp_list[0] and temp[1] == temp_list[1] and temp[2] == temp_list[2] and temp[3] == temp_list[3]:
                        temp[4] += temp_list[4]
                        temp[5] += temp_list[5]
                        break
                else:
                    result_list.append(temp_list)
            elif descprition == 'minute':
                for temp in result_list:
                    if temp[0] == temp_list[0] and temp[1] == temp_list[1] and temp[2] == temp_list[2]:
                        temp[3] += temp_list[3]
                        temp[4] += temp_list[4]
                        break
                else:
                    result_list.append(temp_list)

        # order result_list by concurrency total count
        # sorted_result_list = []
        # if descprition == 'minute':
        #     sorted_result_list = sorted(result_list, key=lambda temp: temp[4], reverse=True)
        # elif descprition == 'second':
        #     sorted_result_list = sorted(result_list, key=lambda temp: temp[5], reverse=True)
        return result_list


# return a list every 5 element's value's summary
def format_reload(input_list, output_list, count):
    interval = 5
    if count < len(input_list) - interval:
        sum_success = 0
        sum_total = 0
        for temp in range(interval):
            sum_success += input_list[count + temp][3]
            sum_total += input_list[count + temp][4]
        temp_list = [
            input_list[count][0],
            input_list[count][1],
            input_list[count][2],
            sum_success,
            sum_total
        ]
        output_list.append(temp_list)
        return format_reload(input_list, output_list, count + interval)
    else:
        return output_list


avg5 = []
for a in format_reload(log_analysis("666.log", "minute"), avg5, 0):
    print(a)