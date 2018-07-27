TARGET=depth_first_search_sedgewick_list_1990 depth_first_search_sedgewick_list_1997 depth_first_search depth_first_search_sedgewick_list_wo_pointer_1997

$(TARGET):

test: depth_first_search_sedgewick_list_1990
	# Figure 29.4, p.422
	./depth_first_search_sedgewick_list_1990 < graph_list.txt

test2: depth_first_search_sedgewick_list_1997
	./depth_first_search_sedgewick_list_1997 < graph_list.txt

test3: depth_first_search depth_first_search_sedgewick_list_wo_pointer_1997
	./depth_first_search_sedgewick_list_wo_pointer_1997 < graph_list.txt

clean:
	rm -f $(TARGET)
