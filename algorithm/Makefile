.PHONY: all

CFLAGS=
INCLUDES=

all: 724 41

724_APP=find_pivot_index
724_OBJS=find_pivot_index.o

41_APP=first_missing_positive
41_OBJS=first_missing_positive.o

724: $(724_OBJS)
	${CXX} ${CFLAGS} ${LDFLAGS} ${724_OBJS} -o ${724_APP}	

41: $(41_OBJS)
	${CXX} ${CFLAGS} ${LDFLAGS} ${41_OBJS} -o ${41_APP}	

.PHONY: clean
clean: clean_724 clean_41

clean_724:
	rm -f $(724_OBJS) $(724_APP)

clean_41:
	rm -f $(41_OBJS) $(41_APP)

%.o:%.cpp
	${CXX} ${CFLAGS} ${INCLUDES} -c $< -o $@

