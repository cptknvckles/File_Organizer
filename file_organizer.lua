-- automated script to move downloads to respective folders
local lfs = require("lfs")
local downloads_dir = "/home/virtualmist/Downloads/"

-- defining destinations for file types
local destinations = {
    ["jpg"] = "/home/virtualmist/Pictures",
    ["png"] = "/home/virtualmist/Pictures",
    ["pdf"] = "/home/virtualmist/Pictures",
    ["mp4"] = "/home/virtualmist/Videos",
    ["mkv"] = "/home/virtualmist/Videos",
    ["avi"] = "/home/virtualmist/Videos"
}
--function to move a file to the appropiate directory
local function move_file(file, dest)
    os.rename(file, dest .. "/" .. file:match("[^/]+$"))
end
--this function moves the file by renmaing it, effectivly moving it to the correct destination folder
--loop through the files in the downloads folder
for file in lfs.dir(downloads_dir) do 
    if file ~= "." and file ~= ".." then
        --get the file extension
        local extension = file:match("^.+(%..+)$")
        extension = extension and extension:sub(2) -- strip the dot from the extension
        --check if the file has a matching destination
        if destinations[extension] then
            move_file(downloads_dir .. "/" .. file, destinations[extension])
            print("moved " .. file .. " to " .. destinations[extension])
        end
    end
end
--this code loops through each file in the downloads directory, extracts the file extension, and moves it to the folder, if
--it matches one in the destinations table