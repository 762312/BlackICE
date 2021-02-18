import os
import zipfile
import zlib
import time

# This will quickly create a zip with the files needed to run the mod.


Modfolders = ["./battleplans","./cgm","./common","./decisions","./events","./history","./localisation","./map",
                "./interface","./music","./script","./sound","./technologies","./units"]


print("Do you want to include the GFX folder? [Y/N]\nIt will take much longer if you do.")
x = input()
if x.lower() == "y":
    Modfolders.append("./gfx")

def zipdir(path):
    for root, dirs, files in os.walk(path):
        if root.split("\\")[0] not in Modfolders:
            print("skipped " + root )
            continue
        else:
            for file in files:
                print("included " + str(root) + "/" + str(file))
                zipf.write(os.path.join(root, file))

zipf = zipfile.ZipFile('BlackICE.zip', 'w', zipfile.ZIP_DEFLATED)
zipdir('./')
zipf.close()

print("All done! :)" )
time.sleep(5)
