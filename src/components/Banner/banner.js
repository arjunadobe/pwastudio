import React, { Component } from 'react';
import PropTypes from 'prop-types';
import classify from 'parentSrc/classify';
import Carousel from 'nuka-carousel';
import defaultClasses from './banner.css';
import banner1 from './Main_Banner1.jpg';
import banner2 from './Main_Banner2.jpg';
import banner3 from './Main_Banner3.jpg';

class Banner extends Component {
    static propTypes = {
        classes: PropTypes.shape({
            root: PropTypes.string
        })
    };

    render() {
        const { props } = this;
        const { classes } = props;
        return (
            <div className={classes.root}>
                <Carousel>
                    <img src={banner1} />
                    <img src={banner2} />
                    <img src={banner3} />
                </Carousel>
            </div>
        );
    }
}

export default classify(defaultClasses)(Banner);
