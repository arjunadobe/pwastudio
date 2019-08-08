import React, { Suspense } from 'react';
import { bool, func, shape, string } from 'prop-types';
import { Menu as MenuIcon, Search as SearchIcon } from 'react-feather';

import Icon from 'parentComponents/Icon';
import Logo from 'parentComponents/Logo';
import { Link, resourceUrl, Route } from '@magento/venia-drivers';

import CartTrigger from 'parentComponents/Header/cartTrigger';
import NavTrigger from 'parentComponents/Header/navTrigger';
import SearchTrigger from 'parentComponents/Header/searchTrigger';
import OnlineIndicator from 'parentComponents/OnlineIndicator';

import { mergeClasses } from 'parentSrc/classify';
import defaultClasses from './header.css';

const SearchBar = React.lazy(() => import('parentComponents/SearchBar'));

const Header = props => {
    const { hasBeenOffline, isOnline, searchOpen, toggleSearch } = props;

    const classes = mergeClasses(defaultClasses, props.classes);
    const rootClass = searchOpen ? classes.open : classes.closed;
    const searchIcon = <Icon src={SearchIcon} />;
    const suspenseFallback = (
        <div className={classes.searchFallback}>
            <div className={classes.input}>
                <div className={classes.loader} />
            </div>
        </div>
    );

    return (
        <header className={rootClass}>
            <div className={classes.toolbar}>
                <div className={classes.primaryActions}>
                    <NavTrigger>
                        <Icon src={MenuIcon} />
                    </NavTrigger>
                </div>
                <OnlineIndicator
                    hasBeenOffline={hasBeenOffline}
                    isOnline={isOnline}
                />
                <div className={classes.secondaryActions}>
                    <SearchTrigger
                        searchOpen={searchOpen}
                        toggleSearch={toggleSearch}
                    >
                        {searchIcon}
                    </SearchTrigger>
                    <CartTrigger />
                </div>
            </div>
            <Suspense fallback={searchOpen ? suspenseFallback : null}>
                <Route
                    render={({ history, location }) => (
                        <SearchBar
                            isOpen={searchOpen}
                            history={history}
                            location={location}
                        />
                    )}
                />
            </Suspense>
        </header>
    );
};

Header.propTypes = {
    classes: shape({
        closed: string,
        logo: string,
        open: string,
        primaryActions: string,
        secondaryActions: string,
        toolbar: string
    }),
    searchOpen: bool,
    toggleSearch: func.isRequired
};

export default Header;
