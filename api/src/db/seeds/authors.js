const authors = [
  {
    source: 'medium',
    first_name: 'Gabriella',
    second_name: 'Medas',
    url: 'https://medium.com/feed/@gabriellamedas',
  },
  {
    source: 'medium',
    first_name: 'Andrew',
    second_name: 'MacMurray',
    url: 'https://medium.com/feed/@andrewMacmurray',
  },
  {
    source: 'medium',
    first_name: 'Katerina',
    second_name: 'Georgiou',
    url: 'https://medium.com/feed/@katerinacodes',
  },
  {
    source: 'medium',
    first_name: 'Himalee',
    second_name: 'Tailor',
    url: 'https://medium.com/feed/@himalee.tailor',
  },
  {
    source: 'medium',
    first_name: 'Devlin',
    second_name: 'Glasman',
    url: 'https://medium.com/feed/@devlin.glasman',
  },
  {
    source: 'jekyll',
    first_name: 'Laurent',
    second_name: 'Curau',
    url: 'https://laurentcurau.com/feed.xml',
  },
  {
    source: 'medium',
    first_name: 'Marion',
    second_name: 'LV',
    url: 'https://medium.com/feed/@codeidoscope',
  },
];

const deleteExistingAuthorsQuery = `DELETE FROM authors`;
const authorValue = a =>
  `('${a.first_name}', '${a.second_name}', '${a.url}', '${a.source}')`;

const authorsValues = authors.map(authorValue).join(',');

const addAuthorsQuery = `
  INSERT INTO authors (first_name, second_name, blog_url, blog_source)
  VALUES ${authorsValues};
`;

module.exports = {
  deleteExistingAuthorsQuery,
  addAuthorsQuery,
};
