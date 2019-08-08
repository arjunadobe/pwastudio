import React, { Component } from 'react';

import classify from 'parentSrc/classify';
import defaultClasses from './topbar.css';
import { shape, string } from 'prop-types';
import Logo from '../Logo';
import { Link, resourceUrl, Route } from '@magento/venia-drivers';

class TopBar extends Component {
    static propTypes = {
        classes: shape({
            root: string,
            logo: string
        })
    };

    render() {
        const { classes } = this.props;

        return (
            <div className={classes.root}>
                <Link to={resourceUrl('/')}>
                    <Logo classes={{ logo: classes.logo }} />
                </Link>
            </div>
        );
    }
}

export default classify(defaultClasses)(TopBar);
