'''
Date: 2019/10/21
By Chen Guan'en
Q: Write a program to generate a table of lexical diversity scores
(i.e. token/type ratios), as we saw in 1.1. Include the full set 
of Brown Corpus genres (nltk.corpus.brown.categories()). Which 
genre has the lowest diversity (greatest number of tokens per type)? 
Is this what you would have expected?
'''

import nltk
def tabulate(cfdist, words):
    print('{:>20}'.format('Genre'), end= ' ')
    for word in words:
        print('{:>10}'.format(word), end= ' ')
    print()
    for key in cfdist.keys():
        print('{:20}'.format(key), end=' ')
        for word in cfdist[key]:
            print('{:10}'.format(word), end= ' ') # print table cell
        print()

datas = {}
field_name=['Tokens', 'Types','Lexical diversity']
brown = nltk.corpus.brown
for category in brown.categories():
        text = brown.words(categories=category)
        data = []
        data.append(len(text))
        data.append(len(set(text)))
        if data[0] == 0:
            data.append(0)
        else:
            data.append(round(data[1]/data[0],2))
        datas[category]=data
tabulate(datas, field_name)
# the genre of 'humor' has the lowest diversity.


