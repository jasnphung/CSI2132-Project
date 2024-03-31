CREATE TABLE HotelChain (
    chain_name varchar,
    central_office_address varchar,
    phone_number int,
    email_address varchar,
    number_of_hotels int,

    PRIMARY KEY(chain_name)
);


INSERT INTO HotelChain (chain_name, central_office_address, phone_number, email_address, number_of_hotels)
VALUES
    ('Marriott', '123 Central St, Ottawa', 1234567890, 'MariottCanada@mariott.com', 8),
    ('Hilton', '456 Main St, Ottawa', 1234567891, 'hiltonCanada@hiltonhotels.com', 10),
    ('Les Suites', '789 Downtown Ave, Ottawa', 1234567892, 'lessuitesOtt@lessuites.com', 9),
    ('Best Western', '321 River Rd, Ottawa', 1234567893, 'bestWesternOtt@bestwestern.com', 12),
    ('Four Seasons', '654 Park Blvd, Ottawa', 1234567894, 'fourSeasonsinOttawa@fourseasons.com', 11);
