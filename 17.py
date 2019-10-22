'''
Date:2019/10/21 Mon
By Chen Guan'en
Q: Write a function that finds the 50 most frequently occurring 
words of a text that are not stopwords.
'''
import nltk
from nltk.corpus import stopwords

def frq_word(text):
    # lowercase such words as 'He'
    text = [word.lower() for word in text]
    # select words that are alphabets and without stopwords
    text = [word for word in text if word.isalpha() and (word not in stopwords.words('english'))] 
    fdist = nltk.FreqDist(text)
    fdist.plot(50)
    
# test function 
from nltk.corpus import brown
frq_word(brown.words(categories=brown.categories()[0]))
