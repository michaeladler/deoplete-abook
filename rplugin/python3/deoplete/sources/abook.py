# Copyright (c) 2017 Filip Szymański. All rights reserved.
# Use of this source code is governed by an MIT license that can be
# found in the LICENSE file.

import configparser
import os.path
import re

from .base import Base  # pylint: disable=E0401

class Source(Base):
    COLON_PATTERN = re.compile(r':\s?')
    COMMA_PATTERN = re.compile(r'.+,\s?')
    HEADER_PATTERN = re.compile(r'^(Bcc|Cc|From|Reply-To|To):(\s?|.+,\s?)')

    def __init__(self, vim):
        super().__init__(vim)

        self.__cache = []

        self.filetypes = ['mail']
        self.mark = '[abook]'
        self.matchers = ['matcher_length', 'matcher_full_fuzzy']
        self.min_pattern_length = 0
        self.name = 'abook'

    def __make_cache(self, context):
        datafile = context['vars'].get('deoplete#sources#abook#datafile',
                                       os.path.expanduser('~/.abook/addressbook'))

        addressbook = configparser.ConfigParser()
        addressbook.read(datafile)
        for section in addressbook.sections():
            emails = addressbook.get(section, 'email', fallback=None)
            if emails is not None:
                name = addressbook.get(section, 'name', fallback=None)
                for email in emails.split(','):
                    if name is not None:
                        email = '{0} <{1}>'.format(name, email)

                    self.__cache.append({'word': email})

    def gather_candidates(self, context):
        if self.HEADER_PATTERN.search(context['input']) is not None:
            if not self.__cache:
                self.__make_cache(context)

            return self.__cache

    def get_complete_position(self, context):  # pylint: disable=R0201
        colon = self.COLON_PATTERN.search(context['input'])
        comma = self.COMMA_PATTERN.search(context['input'])
        return max(colon.end() if colon is not None else -1,
                   comma.end() if comma is not None else -1)

    def on_event(self, context):
        self.__make_cache(context)

# vim: ts=4 et sw=4
