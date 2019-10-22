'''
Q: Write a function that finds the 50 most frequently occurring 
words of a text that are not stopwords.
'''
import nltk
from nltk.corpus import stopwords

def frq_word(text):
    # lower
    text = [word.lower() for word in text]
    text = list(nltk.bigrams(text))
    re_text=[]
    for text_ in text:
        valid_flag = 1
        for word in text_:
            if not word.isalpha():
                valid_flag = 0
                continue
            if word in stopwords.words('english'):
                valid_flag= 0
                continue
        if valid_flag:
            re_text.append(text_)
    fdist = nltk.FreqDist(re_text)
    fdist.plot(50)

# test function 
from nltk.corpus import brown
frq_word(brown.words(categories=brown.categories()[0]))
