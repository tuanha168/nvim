local a = "git@yopaz:myhm-inc/knot-builder-web.git"
print(a:gsub("^git@yopaz:(.+)%.git$","https://github.com/%1"))
