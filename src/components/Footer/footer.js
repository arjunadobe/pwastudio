import React, { Component } from 'react';
import PropTypes from 'prop-types';

import classify from 'parentSrc/classify';
import defaultClasses from 'parentComponents/Footer/footer.css';
import storeConfigDataQuery from '../../queries/getStoreConfigData.graphql';
import { Query } from 'parentSrc/drivers';

class Footer extends Component {
    static propTypes = {
        classes: PropTypes.shape({
            copyright: PropTypes.string,
            root: PropTypes.string,
            tile: PropTypes.string,
            tileBody: PropTypes.string,
            tileTitle: PropTypes.string
        })
    };

    render() {
        const { classes } = this.props;

        return (
            <footer className={classes.root}>
                <div className={classes.tile}>
                    <h2 className={classes.tileTitle}>
                        <span>Custom Footer Heading</span>
                    </h2>
                    <p className={classes.tileBody}>
                        <span>
                            this component is overwritten inside your own shop
                            but the styling is still resolved from
                            "venia-concept" because we don't need to change
                            styling
                        </span>
                    </p>
                </div>
                <div className={classes.tile}>
                    <h2 className={classes.tileTitle}>
                        <span>Your Account</span>
                    </h2>
                    <p className={classes.tileBody}>
                        <span>
                            Sign up and get access to our wonderful rewards
                            program.
                        </span>
                    </p>
                </div>
                <small className={classes.copyright}>
                    <Query query={storeConfigDataQuery}>
                        {({ loading, error, data }) => {
                            if (error) {
                                return (
                                    <span className={classes.fetchError}>
                                        Data Fetch Error:{' '}
                                        <pre>{error.message}</pre>
                                    </span>
                                );
                            }
                            if (loading) {
                                return (
                                    <span className={classes.fetchingData}>
                                        Fetching Data
                                    </span>
                                );
                            }

                            return <span>{data.storeConfig.copyright}</span>;
                        }}
                    </Query>
                </small>
            </footer>
        );
    }
}

export default classify(defaultClasses)(Footer);
