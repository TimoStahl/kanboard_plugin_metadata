
PROJNAME=	Metadata
VERSION=	1.0.33.1

include files.mk

dist: ${PROJNAME}-${VERSION}
	zip -r '${PROJNAME}-${VERSION}.zip' '${PROJNAME}-${VERSION}'

${PROJNAME}-${VERSION}: ${DISTFILES}
	[ ! -d '${PROJNAME}-${VERSION}' ] || rm -rf '${PROJNAME}-${VERSION}'
	mkdir '${PROJNAME}-${VERSION}'
	for files in ${DISTFILES}; do \
		dn=$$(dirname -- "$${files}"); \
		[ -d "${PROJNAME}-${VERSION}/$${dn}" ] || mkdir -p "${PROJNAME}-${VERSION}/$${dn}"; \
		cp "$${files}" "${PROJNAME}-${VERSION}/$${dn}"; \
	done


files.mk: .files.mk
	mv .files.mk files.mk

clean:
	rm -rf files.mk .files.mk '${PROJNAME}-${VERSION}'*

.files.mk:
	+(printf 'DISTFILES=\\\n'; \
	  find . -type f \
		! -path '*/.git*' \
		! -name 'Makefile' \
		! -name 'files.mk' | \
		sed -e 's|$$| \\|'; \
		printf '\n'; \
	) >./.files.mk
