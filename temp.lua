local a = "git@yopaz:myhm-inc/knot-builder-web.git"
a:gsub("^git@yopaz:(.+)%.git$","https://github.com/%1")
print(a)
