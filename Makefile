VER ?= dev
PKGNAME := tonyzhang/notebook:$(VER)

build:
	docker build -t $(PKGNAME) .

push:
	docker tag $(PKGNAME) $(PKGNAME)
	docker push $(PKGNAME)
