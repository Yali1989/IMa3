CC1 = mpicxx
CC2 = g++
FLAGS = -O3 -fpermissive
SKIPTINYFILES := $(filter-out $(wildcard tiny*.cpp),$(wildcard *.cpp))

all: $(SKIPTINYFILES)
	$(CC1) $(SKIPTINYFILES) -D MPI_ENABLED -D NDEBUG -o IMa3 $(FLAGS)

singlecpu:  $(SKIPTINYFILES)
	$(CC2) $(SKIPTINYFILES) -U MPI_ENABLED -D NDEBUG -o IMa3_singlecpu $(FLAGS)

testbed:
	$(CC1) *.cpp -D MPI_ENABLED -D NDEBUG -D STDTEST -D XMLOUTPUT -o IMa3_stdtest $(FLAGS)

debug:
	$(CC1) *.cpp -D MPI_ENABLED -D DEBUG -o IMa3 $(FLAGS)

valgrind: $(SKIPTINYFILES)
	$(CC1) $(SKIPTINYFILES) -D MPI_ENABLED -g -O3 -o IMa3_valgrind $(FLAGS)

gprof:  $(SKIPTINYFILES)
	$(CC2) $(SKIPTINYFILES) -U MPI_ENABLED -D NDEBUG -o IMa3_gprof $(FLAGS) -pg -g -no-pie
	
clean:
	rm IMa3 IMa3_singlecpu IMa3_stdtest
	rm *.o
