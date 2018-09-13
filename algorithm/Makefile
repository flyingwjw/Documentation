.PHONY: all

CFLAGS=
INCLUDES=

all: 724

724_APP=find_pivot_index
724_OBJS=find_pivot_index.o

724: $(724_OBJS)
	${CXX} ${CFLAGS} ${LDFLAGS} ${724_OBJS} -o ${724_APP}	

.PHONY: clean
clean: clean_724

clean_724:
	rm -f $(724_OBJS) $(724_APP)

%.o:%.cpp
	${CXX} ${CFLAGS} ${INCLUDES} -c $< -o $@

