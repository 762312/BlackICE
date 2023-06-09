import pandas as pd
import matplotlib.pyplot as plt
import tkinter as tk
import os

################# INFO #################
# Create Plots of collected statistics #
########################################
#
# Place the script within the Stats folder and run
#

def getTag():
    return e_TAG.get()

def getStats():
    stats = [lb_STAT.get(i) for i in lb_STAT.curselection()]
    return stats

def plot():
    if same_chart.get() == 0:
        plt.figure()

    tag = getTag()
    stats = getStats()
    if not tag:
        return
    if not stats:
        return

    for stat in stats:
        if verify(tag=tag, stat=stat):
            plot_line(tag=tag,stat=stat)

    plt.show()


def plot_line(tag, stat, title=None):
    if not title:
        title = stat
    
    data = pd.read_csv(f'{tag}_{stat}')
    data = removeduplicates(data, [stat])
    dates = data["Date"]
    plt.plot(dates, data[stat], label=f"{tag}-{stat}")
    plt.legend()
    plt.xlabel("Day")
    plt.ylabel(f"{tag}-{stat}")
    plt.grid(visible=True)
    plt.xlim(0)
    plt.ylim(0)
    plt.title(stat)
    plt.autoscale()


# Removes duplicate dates from the dataset which can be introduced due to crashing or save reloading
def removeduplicates(data: pd.DataFrame, columns: list[str]):
    ret = {}
    ret["Date"] = {}
    for column in columns:
        ret[column] = {}
    highest_day = 0
    for k in ret.keys():
        x = 0
        for day in data["Date"]:
            if day > highest_day:
                highest_day = day
            elif day < highest_day:
                for j in range(day, highest_day + 1):
                    ret[k].pop(j, None)
                highest_day = day

            ret[k][day] = data[k][x]
            x += 1

    vals = {}
    for k in ret.keys():
        vals[k] = ret[k].values()
    return vals


def verify(tag, stat):
    if len(tag) != 3:
        return False
    if os.path.exists(f"{tag}_{stat}"):
        return True
    return False


def setPossibleStatSelection():
    stats = set()
    for root, dirs, files in os.walk("./"):
        for file in files:
            if file in ["visualizeStatistic.py", "zzSetup"]:
                continue
            stat_name = file[4:]
            stats.add(stat_name)
    stats = list(stats)
    stats = sorted(stats)
    for i in range(len(stats)):
        lb_STAT.insert(i, stats[i])


app = tk.Tk()
app.title("visualizeStatistics.py")

e_TAG = tk.Entry(app, width=25, border=5)
e_TAG.insert(0, "Enter TAG")

lb_STAT = tk.Listbox(app, selectmode=tk.EXTENDED, width=40, height=20)

same_chart = tk.IntVar()
same_chart.set(0)
cb = tk.Checkbutton(app, text="Same Chart", variable=same_chart, onvalue=1, offvalue=0)


button_Show = tk.Button(app, text="Plot", width=25, command= lambda: plot())



e_TAG.grid(row=0, column=0, padx=10, pady=10)
lb_STAT.grid(row=0, column=1, padx=10, pady=10)
cb.grid(row=0, column=2, padx=10, pady=10)
button_Show.grid(row=1, column=1, padx=10, pady=10, )
if __name__ == "__main__":
    setPossibleStatSelection()
    app.mainloop()
