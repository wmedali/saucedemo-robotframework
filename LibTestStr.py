#!/usr/bin/env python3

def clean_phrase(str1):
    # Nettoyage de la phrase
    str1.lower()
    list_carac=list("$")

    str_cleaned=str1
    for c in list_carac:
        str_cleaned=str_cleaned.replace(c, "")

    return str_cleaned
