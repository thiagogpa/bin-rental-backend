create table bins
(
    id int auto_increment
        primary key,
    waste_type enum('CONSTRUCTION', 'MIXED WASTE', 'CLEAN FILL') not null,
    size_long int not null,
    size_height int not null,
    size_wide int not null,
    daily_cost double not null,
    description varchar(2000) not null,
    amount int null,
    created_at datetime not null,
    updated_at datetime not null,
    deleted_at datetime null
);

create table users
(
    id int auto_increment
        primary key,
    first_name varchar(255) not null,
    last_name varchar(255) not null,
    phone varchar(255) not null,
    email varchar(255) not null,
    staff tinyint(1) not null,
    created_at datetime not null,
    updated_at datetime not null,
    deleted_at datetime null
);

create table addresses
(
    id int auto_increment
        primary key,
    street varchar(255) not null,
    number_street varchar(255) not null,
    city varchar(255) not null,
    province varchar(255) not null,
    zipcode varchar(255) not null,
    created_at datetime not null,
    updated_at datetime not null,
    deleted_at datetime null,
    user_id int null,
    constraint addresses_ibfk_1
        foreign key (user_id) references users (id)
            on update cascade on delete set null
);

create index user_id
    on addresses (user_id);

create table logins
(
    username varchar(255) not null
        primary key,
    password varchar(255) not null,
    created_at datetime not null,
    updated_at datetime not null,
    user_id int null,
    constraint logins_ibfk_1
        foreign key (user_id) references users (id)
            on update cascade on delete set null
);

create index user_id
    on logins (user_id);

create table orders
(
    id int auto_increment
        primary key,
    order_date datetime not null,
    drop_off_date datetime not null,
    pick_up_date datetime not null,
    subtotal double not null,
    taxes double not null,
    status enum('In progress', 'Delivered', 'Complete') null,
    created_at datetime not null,
    updated_at datetime not null,
    deleted_at datetime null,
    user_id int null,
    address_id int null,
    constraint orders_ibfk_1
        foreign key (user_id) references users (id)
            on update cascade on delete set null,
    constraint orders_ibfk_2
        foreign key (address_id) references addresses (id)
            on update cascade on delete set null
);

create index address_id
    on orders (address_id);

create index user_id
    on orders (user_id);

create table ordersbins
(
    selected int not null,
    created_at datetime not null,
    updated_at datetime not null,
    deleted_at datetime null,
    order_id int default 0 not null,
    bin_id int default 0 not null,
    primary key (order_id, bin_id),
    constraint ordersbins_ibfk_1
        foreign key (order_id) references orders (id)
            on update cascade on delete cascade,
    constraint ordersbins_ibfk_2
        foreign key (bin_id) references bins (id)
            on update cascade on delete cascade
);

create index bin_id
    on ordersbins (bin_id);

