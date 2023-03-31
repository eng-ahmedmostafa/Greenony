# Greenony
The farmer usually chooses his crop randomly, which negatively affects the soil and the quantity and quality of the crop.

Greenony uses soil analysis data to create a record for each agricultural area and suggests what exactly the minerals and chemicals you need in the required amount.

The inputs to this model are soil analysis data, and weather parameters which consist of many features like pH, organic matter, nitrogen, phosphorus, and potassium. These features are represented in the code by the X variable, which is a pandas dataframe containing the values of the features.

The outputs of this model are soil needs, which are represented by the y variable in the code. In this case, the soil needs are represented as binary values of 0 or 1, where 0 represents low soil needs and 1 represents high soil needs. The model predicts the soil needs based on the input soil analysis data, using a binary classification approach.
