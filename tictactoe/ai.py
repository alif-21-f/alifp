from math import inf, sqrt, log
from random import randint
from copy import deepcopy
import time
import game

boards = 0


class Node:

    def __init__(self, board, player_id, move):
        self.wins = 0.0
        self.games = 0.0
        self.move = move
        self.board = board
        self.player_id = player_id
        self.children = []


def mcts(node, expanding=False):

    global boards
    boards += 1

    node.games += 1
    if game.check_win(node.board) != ' ':
        if game.check_win(node.board) == 'X' or game.check_win(node.board) == 'O':
            node.wins += 1
        return

    # Selection
    move = -1
    next_player = 'O' if node.player_id == 'X' else 'X'
    next_board = deepcopy(node.board)
    if len(node.children) == 25:
        max_uct = -inf
        for child in node.children:
            uct = child.wins/child.games + sqrt(log(node.games) / child.games)
            if uct > max_uct:
                max_uct = uct
                move = child.move

    # Expansion and Simulation
    elif not expanding:
        for move_expansion in range(25):
            if node.board[move_expansion] != ' ':
                continue
            next_board = deepcopy(node.board)
            next_board[move_expansion] = node.player_id
            next_node = Node(next_board, next_player, move_expansion)
            is_child = False
            for child in node.children:
                if child.board == next_board:
                    next_node = child
                    is_child = True
            if not is_child:
                node.children.append(next_node)
            mcts(next_node, True)
    else:
        move = randint(0, 24)
        while node.board[move] != ' ':
            move = randint(0, 24)
        next_board[move] = node.player_id
        next_node = Node(next_board, next_player, move)
        is_child = False
        for child in node.children:
            if child.board == next_board:
                next_node = child
                is_child = True
        if not is_child:
            node.children.append(next_node)
        mcts(next_node, expanding)

    # Back-Propagation
    node.wins = 0
    node.games = 0
    if node.children:
        for child in node.children:
            node.wins += child.games - child.wins
            node.games += child.games


def minimax_ab(board, player_id, depth, maximize, alpha=-inf, beta=-inf) -> (int, int): # type: ignore

    winner = game.check_win(board)
    if winner == player_id:
        return None, 10 + depth
    if winner not in (' ', "draw"):
        return None, -10 - depth
    if winner == "draw":
        return None, 0
    if depth == 0:
        return None, None

    global boards
    boards += 1

    best_move = None
    value = None

    for i in range(25):
        if board[i] == ' ':
            board[i] = player_id
            _, value = minimax_ab(board,
                                  'O' if player_id == 'X' else 'X',
                                  depth - 1,
                                  False,
                                  alpha,
                                  beta)
            board[i] = ' '
            if (value is not None
                    and (value > alpha if maximize else value < beta)):
                if maximize:
                    alpha = value
                else:
                    beta = value
                if (alpha != -inf and beta != inf
                    and alpha >= beta if maximize else beta >= alpha):
                    break
                best_move = i

    if maximize:
        return best_move, alpha

    return best_move, beta



def ai_move(board, player_id, algorithm):
    """
    ai_move is a wrapper for the minimax_ab function.
    """

    global boards
    boards = 0

    if algorithm == "minimax":

        move, _ = minimax_ab(board, player_id, 5, True)

        if move is None:
            move = randint(0, 24)

        board[move] = player_id
        print(f"Calls to minimax_ab: {boards}")

    elif algorithm == "mcts":

        move = -1
        root = Node(board, player_id, -1)
        start = time.time()
        turn_length = 15
        while time.time() < start + turn_length:
            mcts(root)

        best_score = -inf
        print(f"length of children: {len(root.children)}")
        for child in root.children:
            if child.wins / child.games > best_score:
                move = child.move
                best_score = child.wins / child.games

        if move == -1:
            print("Random move")
            move = randint(0, 24)

        board[move] = player_id
        print(f"Calls to mcts: {boards}")
    elif algorithm == "alpha-beta":  # Add this block
        move = alpha_beta_pruning(board, 5, float('-inf'), float('inf'), True)
        if move is None:
            move = randint(0, 24)
        board[move] = player_id
        print(f"Calls to alpha_beta_pruning: {boards}")


def game_over(position):
    # Check if there's a winner
    winner = game.check_win(position)
    if winner in ('X', 'O'):
        return True

    # Check if there are no more valid moves
    if ' ' not in position:
        return True

    return False

def evaluate(position):
    # This is a very basic heuristic that counts the number of 'X's and 'O's
    # You should replace this with a heuristic that fits your game's strategy
    x_count = position.count('X')
    o_count = position.count('O')
    return x_count - o_count

def generate_moves(position):
    # Generate a list of all indices where the position is ' '
    return [i for i, x in enumerate(position) if x == ' ']


def alpha_beta_pruning(position, depth, alpha, beta, maximizing_player):
    if depth == 0 or game_over(position):
        return evaluate(position)

    if maximizing_player:
        max_eval = float('-inf')
        for child in generate_moves(position):
            eval = alpha_beta_pruning(child, depth - 1, alpha, beta, False)
            max_eval = max(max_eval, eval)
            alpha = max(alpha, eval)
            if beta <= alpha:
                break
        return max_eval
    else:
        min_eval = float('inf')
        for child in generate_moves(position):
            eval = alpha_beta_pruning(child, depth - 1, alpha, beta, True)
            min_eval = min(min_eval, eval)
            beta = min(beta, eval)
            if beta <= alpha:
                break
        return min_eval