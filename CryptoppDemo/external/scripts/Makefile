CXXFLAGS += -g -O2 -Wall -Wno-unused -Wno-unknown-pragmas -DNDEBUG -DCRYPTOPP_DISABLE_ASM -DCRYPTOPP_DISABLE_SSE2 -MMD -MT dependencies

TARGET = libcryptopp.a
SRCS = $(shell echo *.cpp)
OBJS = $(SRCS:.cpp=.o)

.phoney: clean

all: $(TARGET)

$(TARGET): $(OBJS)
	$(AR) $(ARFLAGS) $@ $(OBJS)
	$(RANLIB) $@

%.o : %.cpp
	$(CXX) $(CXXFLAGS) -c $<

clean:
	$(RM) $(TARGET) $(OBJS)

