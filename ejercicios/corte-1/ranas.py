import networkx as nx
import matplotlib.pyplot as plt
from networkx.drawing.nx_agraph import graphviz_layout

def valid_moves(state):
    moves = []
    for i, frog in enumerate(state):
        if frog == 'G' and i < len(state) - 1 and state[i+1] == 'V':
            moves.append(state[:i] + 'V' + 'G' + state[i+2:])
        if frog == 'G' and i < len(state) - 2 and state[i+1] != 'V' and state[i+2] == 'V':
            moves.append(state[:i] + 'V' + state[i+1] + 'G' + state[i+3:])
        if frog == 'M' and i > 0 and state[i-1] == 'V':
            moves.append(state[:i-1] + 'M' + 'V' + state[i+1:])
        if frog == 'M' and i > 1 and state[i-1] != 'V' and state[i-2] == 'V':
            moves.append(state[:i-2] + 'M' + state[i-1] + 'V' + state[i+1:])
    return moves

def build_tree(state, graph, depth=0, max_depth=5):
    if depth > max_depth or state == 'MMMVGGG':
        return
    moves = valid_moves(state)
    for move in moves:
        if move not in graph:
            build_tree(move, graph, depth+1, max_depth)
        graph.add_edge(state, move)

state = "GGGVMMM"
graph = nx.DiGraph()
build_tree(state, graph)

pos = graphviz_layout(graph, prog="dot")
nx.draw(graph, pos, with_labels=True, node_size=600, node_color="lightblue", arrowsize=10)
plt.show()