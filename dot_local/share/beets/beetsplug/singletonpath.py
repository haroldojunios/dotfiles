from collections import Counter

from beets import config
from beets.plugins import BeetsPlugin
from beets.ui import _open_library


class SingletonPath(BeetsPlugin):
    def __init__(self):
        super().__init__()
        lib = _open_library(config)
        items = lib.items()
        singletons = [i for i in items if i.singleton]
        self.artists_counts = dict(Counter(i.artist for i in singletons))
        self.template_fields["singleton_path"] = self._tmpl_singleton_path

    def _tmpl_singleton_path(self, item):
        return self.artists_counts.get(item.artist, 0) >= 5
