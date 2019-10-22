'''
Q: Write a program to generate a table of lexical diversity scores
(i.e. token/type ratios), as we saw in 1.1. Include the full set 
of Brown Corpus genres (nltk.corpus.brown.categories()). Which 
genre has the lowest diversity (greatest number of tokens per type)? 
Is this what you would have expected?
'''

import nltk
from nltk.corpus import brown
def tabulate(cfdist, words):
    print('{:>20}'.format('Words'), end=' ')
    for word in words:
        print('{:>10}'.format(word), end=' ')
    print()
    for key in cfdist.keys():
        print('{:20}'.format(key), end=' ')
        for w in cfdist[key]:
            for frq in word.values():
                print('{:10}'.format(frq), end=' ') # print table cell
        print()


def frq_word(words):
    genres = brown.categories()
    frq = { genre:0 for genre in genres }
    datas = { word:frq for word in words }
    for genre in genres:
        text = brown.words(categories=genre)
        for word in text:
            if word in words:
                datas[word][genre] += 1
    tabulate( datas, genres )


frq_word(['i','he','is'])
